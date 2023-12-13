//
//  ProfileItem.swift
//  GestionUser
//
//  Created by ayouboueslati on 6/12/2023.
//

import SwiftUI

struct ProfileItem: View {
    var title: String
    var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)

            Text(value)
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.7)))
    }
}
