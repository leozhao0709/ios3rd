//
//  ContentView.swift
//  weatherApp
//
//  Created by Lei Zhao on 11/6/20.
//

import SwiftUI
import Alamofire
import CoreLocation
import SwiftyJSON
import Combine

struct ContentView: View {

    let appid = "ea82790127031a954597502b1c33586c"
    @ObservedObject var locationManager = LocationManager.sharedInstance()
    @State private var temp = "0"
    @State private var city = "正在获取位置..."

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    Image("background")
                      .resizable()
                      .frame(width: proxy.size.width, height: proxy.size.height)
                      .scaledToFit()


                    VStack {
                        Spacer()
                          .frame(height: 30)
                        HStack {
                            Spacer()
                            VStack(alignment: .trailing) {
                                NavigationLink(destination: Text("123")) {
                                    Image("switch")
                                }
                                  .padding(.trailing, 20)

                                Text("\(self.temp)°")
                                  .foregroundColor(.white)
                                  .font(.system(size: 100))
                                  .padding(.trailing, 40)
                            }
                        }
                          .padding(.top, 50)
                        Spacer()

                        Image("sunny")
                          .resizable()
                          .frame(width: 180, height: 180)

                        HStack {
                            Text(self.city)
                              .foregroundColor(.white)
                              .font(.system(size: 50))
                              .offset(x: 10)
                            Spacer()
                        }
                          .padding(.bottom, 100)
                    }
                }
            }
              .navigationBarHidden(true)
              .edgesIgnoringSafeArea(.all)
              .onReceive(locationManager.$lastLocation) {
                  updateLocation(location: $0)
              }
        }
    }

    func updateLocation(location: CLLocation?) {
        guard let lon = location?.coordinate.longitude,
              let lat = location?.coordinate.latitude else {
            return
        }
        let params: [String: Any] = ["appid": appid, "lat": lat, "lon": lon]
        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: params)
          .responseJSON { response in
              print(response)
              switch response.result {
              case .success(let value):
                  let resp = JSON(value)
                  let tempResp = resp["main", "temp"].double ?? Double(self.temp)!
                  self.temp = String(format: "%.2f", tempResp - 273.15)
                  self.city = resp["name"].stringValue
              case .failure(let error):
                  print(error)
              }
          }
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: ContentView_Previews.previews)
        }
    #endif
}
