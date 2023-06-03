//
//  NavBar.swift
//  Reshenie-Test
//
//  Created by Kovs on 03.06.2023.
//

import SwiftUI
import UIKit

struct NavBar: View {
    
    var presenter: MainPresenterProtocol!
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Фильмы")
                .bold()
                .font(.system(size: 18))
            
            Spacer()
            
            Button {
                openVC(vc: MainVC())
                print("oops")
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(uiColor: UIColor(named: Colors.rtBlue)!))
                    .font(.system(size: 20))
            }
            
        }
        .padding(25)
        .frame(height: 100)
    }
    
    func openVC(vc: UIViewController) {
        let coordinator = Builder()
        let searchVC = coordinator.getSearchModule()
        vc.navigationController?.pushViewController(searchVC, animated: true)
    }
    
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
