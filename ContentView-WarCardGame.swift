import SwiftUI

struct ContentView: View {
    
  @State var playerCard = "card7"
  @State var cpuCard = "card13"
    
  @State var playerScore = 0
  @State var cpuScore = 0
    
    var body: some View {
        ZStack{
            Image("background-plain")
                .resizable()
                .ignoresSafeArea()

        VStack{
            
            Spacer()
            
            Image("logo")
            
            Spacer()
            HStack{
                Spacer()
                Image(playerCard)
                Spacer()
                Image(cpuCard)
                Spacer()
            }
            Spacer()

            Button(
                action: {
                    deal()
                },
                label: {
                Image("button")
            })
            
            Spacer()

            HStack{
                Spacer()

                VStack{
                    Text("Player")
                        .font(.headline)
                        .padding(.bottom, 10.0)
                    Text(String(playerScore))
                        .font(.largeTitle)
                }
                Spacer()
                VStack{
                    Text("CPU")
                        .font(.headline)
                        .padding(.bottom, 10.0)
                    Text(String(cpuScore))
                        .font(.largeTitle)
                }
                Spacer()

            }
            .foregroundColor(.white)
        
            Spacer()

        }
            
    }
}
        func deal(){
           let playerCardVal = Int.random(in: 2...14)
            playerCard = "card" + String(playerCardVal)
            
           let cpuCardVal = Int.random(in: 2...14)
            cpuCard = "card" + String(cpuCardVal)
            
            if playerCardVal > cpuCardVal {
                playerScore += 1
            }
            else if playerCardVal < cpuCardVal {
                cpuScore += 1
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
