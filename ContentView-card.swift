import SwiftUI

struct ContentView: View {
    
    var body: some View {
    
        ZStack{
            Color(.systemYellow).ignoresSafeArea()
        
        VStack(alignment: .leading, spacing: 20.0) {
             
                Image("niagarafalls")
                    .resizable()
                    .cornerRadius(30.0)
                    .aspectRatio(contentMode: .fit)
            
            
            HStack {
                Text("Niagara Falls")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star.leadinghalf.fill")
                    }
                    .foregroundColor(.orange)
                    .font(.caption)
                    
                    Text("(Reviews 361)")
                        .foregroundColor(.yellow)
                }
            }
            
            Text("Come visit the falls for an experience of life time")
                .foregroundColor(.black)
            
            HStack {
                Spacer()
                Image(systemName: "fork.knife.circle")
                Image(systemName: "binoculars")
            }
            .foregroundColor(.gray)
            .font(.caption)
        }
        .padding()
        .background(Rectangle().foregroundColor(.white)
        .cornerRadius(10.0)
        .shadow(radius: 15))
        .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
