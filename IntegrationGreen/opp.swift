//
//  Video.swift
//  SwiftUI-List-Starter
//
//  Created by Sean Allen on 4/23/21.
//

import SwiftUI

struct Opp : Identifiable{
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
    let viewCount: Int
    let uploadDate: String
    let salaire: Float
    let entrep : String
    let type : String
}

struct OppList {
    
    static let topTen = [
        Opp(imageName: "https://cdn.inspireuplift.com/uploads/images/seller_products/1688802201_TD210513QQ5.jpg",
              title: "9 Things I Wish I Knew When I Started Programming",
              description: "In this video I discuss 9 things I wish I knew before I started programming. Knowing these things would have made my journey in becoming a full-time iOS developer so much faster and easier. I hope this advice helps someone out there that's early in their career as a software developer.",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
            salaire:5.5,
           entrep: "Cayroll",
           type: "stagiare"),
        
        Opp(imageName: "data:image/png;base64,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",
              title: "Technicien en energi elocienne",
              description: "In this video I discuss 9 things I wish I knew before I started programming. Knowing these things would have made my journey in becoming a full-time iOS developer so much faster and easier. I hope this advice helps someone out there that's early in their career as a software developer.",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
            salaire:10,
            entrep: "ferrari",
        type: "Alternace"),
        
        Opp(imageName: "https://sport.tunisienumerique.com/wp-content/uploads/2020/06/Esp%C3%A9rance-de-tunis-news-1000x600.jpg",
              title: "ingenieur energie renouvlable",
              description: "In this video I discuss 9 things I wish I knew before I started programming. Knowing these things would have made my journey in becoming a full-time iOS developer so much faster and easier. I hope this advice helps someone out there that's early in their career as a software developer.",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
            salaire:35.6,
           entrep: "mercedes",
            type: "CDD"),
              
        Opp(imageName: "https://i.pinimg.com/originals/8e/f5/9d/8ef59dc3c90a3abd56c87a5901709132.jpg",
              title: "khedma touskié",
              description: "In this video I discuss 9 things I wish I knew before I started programming. Knowing these things would have made my journey in becoming a full-time iOS developer so much faster and easier. I hope this advice helps someone out there that's early in their career as a software developer.",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
            salaire:40.9,
           entrep: "Cayroll",
            type: "CDI"),
        
        Opp(imageName: "https://seeklogo.com/images/L/liverpool-fc-logo-027452BE2B-seeklogo.com.png?v=638133601200000000",
              title: "hedheka howa",
              description: "In this video I discuss 9 things I wish I knew before I started programming. Knowing these things would have made my journey in becoming a full-time iOS developer so much faster and easier. I hope this advice helps someone out there that's early in their career as a software developer.",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
            salaire:36,
           entrep: "Cayroll",
            type: "PART_TIME"),
        
        Opp(imageName: "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxIHBhUIBxEWExUWFxYbFhYYFR8cGxseIBoiGhoWGRcgHSsjHRopHRgaIjElJSk3MDEuFyAzRDMsNygxLysBCgoKDg0OFQ8QFy0dHx0tKys3LSstKystLS0tKystLTctLTc3NzcrKysrLS0tLSsrLS0tLSs3LSsrLSsrKysrK//AABEIAOEA4QMBIgACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAABgcDBAUCCAH/xABEEAACAQIDBAYGBwUGBwAAAAAAAQIDBAUGERIhMUEHEyJRYXEUMnKBkaEVIzNCUrHBYpKiwtEIJGNz4fElNDVDU7Lw/8QAFgEBAQEAAAAAAAAAAAAAAAAAAAEC/8QAGBEBAQEBAQAAAAAAAAAAAAAAAAERUTH/2gAMAwEAAhEDEQA/AKNAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD1Tg6k1Cmm29ySWrfgkB5BL8I6MsVxWKnRs5wi/vVWqfv0k1L4IkFDoRv5/b3FrDw6yTfygBWALQuOhK9prWlc2svOc1/IcPFOi7FMPTn6P1sVzpTUv4ddr5AQsGW5tp2lZ0bqEoSXGMouLXmnvMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAfqWr0Rc2Uso22RcIjmfOcVOu9HQtmtXF8Y6x51eaT3R01emjcQ4OT+iiriNp9LZoqehWyW12tFUlH8ST3Qj4y+Gm8lKzfhmUKLo5LtINrc7mpu1f8AmS7U/ZWi7mQfO+ea+O3bd9LXR9mgn9XD2+G3U/Lw3xIVcXErie3Wk2/y8EuS8iosDGOlG7vZPbuJ+zSj1cfdN6zR4yXjNTMmbrbDLt1JQqVFt7VacnspOUlrquSZXpYfQTa+kdIEKj/7dKrP+HZ/mGmMWYcxVcCx2pa2+qipNx0qSi0tXu3M2sI6T6tvJKtOrHzaqr3uXaS8jjdJdLZxx1FzlNfxEQFF80cz2ea7Tqcbo07iOnrwTco+Ox9pDzi2yJZn6MP7u8SyjU6+m9X1Tacl37E1ulp3PetObK2o1pUKqq0JOMlwaejXk0TvKeep29yo3k1Cba+s0+rn3KvBfDrI715agQOcHTm4VE009GmtGnzTXeeS5M15co5ws5Yhh0equoadZBtb92qUmt0k16s1ufyVPVqUqFV0qycZJ6NPin3EV4AAAAAAAAAAAAAAAAAAAAAADcwfDp4vitLDrRazqzjCPm3pq/BcX4ICxeiHLdKjRnnPH0upoa9SpLdKot7qac1Hl3y4b1o+BnnNdXGsUd5WbUn9nHX7KD4eHWS3Nvy03bOzNulLEKeD2FHLGH/Y20IuS/E09IqXjKonOXlGRTVWo6tR1Kj1berZUeAARQt7+zra7WL3d216lFRT9pt/ylQl8/2ebXq8u3d2160tPdGP9WwIH0mUv7zKp3VZfnL/AEIEWX0i0ttVtOU5/Kev5IrQtSAAIqZZJzLUtbmFq5duO6i5Pc0+NtPvpy5fhlo1pxXX6RcHhiVjHMmFJ6SX1ifFabmpL8cXufx4NFbFoZJxb6SoSsbnf16lqv8AGhHVvT/Ep/GcEWIq8G/jdj9HYlO25J9ny5f09xoEUAAAAAAAAAAAAAAAAAAAsnoKw/rszVcVkk/RqMnHX/yT7EPk5FbFpdFt9DDcp3ez9rWlJR8FRoyra/Fr4gRTPOJen4jKqnqqk5TXsLsUl5qKZGDo4+/+JOHKMYJfup/m2c4tSAAIofSvQra+i9G7qP7/AFkvm1+h84WttO8uFb2sXOUnoopatn1Tku0eFZEjh9xFwnCk9Yvy3tPg+PLh4AVRnan1letTXOdZfFtFTlxZhsq2JZhnZ4dSlUkq1RyS4RW298pPdFbnxZVWMYXVwfEJWV9CUJRfBriuTXei1I0gARQ62Xr6VldbdB6STjUh7dN7UX8No5Js4d/z0Euckvju/UFSvpJt4O+V3berLZcfYnHrKa90X8yFk1zNLrstW8prRqgk/OnXlRX8MEiFFqQABFAAAAAAAAAAAAAAAACX5FlrX6t86d7p5+j6/lEiBK8g1VHFaXWcFVUJeEa0XRk/JJ/MsSuJj/8A1efu/wDVHPO1m22dviz6xaN8fNPTT4aHFIodfLWXLjMuIKzwum5P70vuxXfJkh6P+ji4zbU9Jra0bZPtVWvW71DXj58PMuSWM4fkLDvo3BIJyS36b5N/ik/1b8teAGbJOQrTJNn6RdNTrNdqbW/2YrkvBGjm7pJp2tKVKwSnonu3OPlKXB+UfjFkAzHnCvi8pO4npDnFPRaftS5+W5buCIVf4rCXZbc/CO5fvP8ARM1jO8XXg/STStMYq2t/TjRi6tTZnFdiS2npJvTWMmuOuq11e1HgSTM2WLLPmGbM9FPTWFSOmq14NPmvkz51jjtO8Wl0nCXfxX9V8DuYBmK5wCarYZV1hr6uu1B9/B9l+WnjrwHprhZ0yZc5Rvupv46wb7FVLsy8H3PwI2fSuDZ4sc4WX0TmCEYymtNmejT9mXBv4PwK16Reiurl9PEsD1r23F6b5U1498fH/cy0rQ3cFh1mM0acedWmvjJGkSfozw76Uz3aW+m5VVN+UPrHr+7p7wJR0tW0bG49Eobkqc2l53UpfqVgWJ0t3/pOOVdngurgvfrVkvdJ6FdlqQABFAAAAAAAAAAAAAAAADqZcqaYireT0VVOGvc3vg/DtqO/u1OWEBYGfrN4jRp4rRi26qUmkt/WepWjp37a1S7kjpZWyDQwahHF8+y2edO017cu51EuC/Z+PcbWTMUeKYepUJKNba1jJpPYudnZUtGtyqxWqf446ciCZqurqOJS9OqSbbe98d3FN96/+4lRYGaekyVal6HYNW9JLSMIbpacuHD3fErm8zBKq31K97/p3+bOK3rxPwaYy17idw9a0m/y9y4IxAEUMlGtKhLaoycX4MxgDp0sWbWzcxT8VufvXB/InmT+km4wfSip9fS4OlUfaS/Zb/LevIrAF1MW5mDKdlnanLE8kyVK502qlnJqO0+bp67lLy7L8D30Q4K8BtL3MeMwlS6qMqMVJNST02qz0fNRUUvFtEAydZ3eN49Sw3CW9uUt0t/YS41HJb0ku5+HFll9K2YFa2ccuU6866ppSuKk2tqfBwptxSWsmk+/ZjF79WBVmZb+V9fOrV9aTlUl7U3rp5bOz8zjnutUdaq6tTe222eCKAAAAAAAAAAAAAAAAAAAAAOrlzGXgt/12m3TktmrT/FHz5ST0afJpFpYrhNLN+Fq6tpdZKS1jNbnU0XFr7txHhKP3tNe/SmDu5WzNVy7c60e3Tk1t029z04SX4ZLkyxGhi2FVMKuOquVu5S03P8A170aJeVC6sc62DbabaW2pLtL/Mit+v7cfnxIdj3RnWofXYRJTi9dItr4Rn6svfoMFfA3MQwuvhs9i/ozpv8Aai0n5Pg/caZFADasMPrYlW6jD6U6svwwg5P4JAap0MCwWvj+JRw7CabqVJclwS5yk+Ciu9k+y70O3NxH0vM9SNlRW+SbUqmnPdrsx8293cSK9zbZZPwuWGZFpxjyqXU9+r79rjUl3Jdnu1WqAyT9H6KcAeHYe418Qrx+snyivH8NGO/j6zT8dmmsWv3eV25Sc9ZOUpvjOT4zf6LkvNmTF8Vlf1pScpS2nrOcn25vvl3LctI8Fou5acwqAAIoAAAAAAAAAAAAAAAAAAAAAAADLa3M7Suq9rNwkuDi9GTLB+kWvaLZvFtd8o6Jv2oPsy+RCABcdl0kUa0Nmsqcu9S+rfv1Th8EbH0/hVy+sucNpzb5xp0pfxaopQFTF3LMOE2z26GE09VznSpL56sx3nSy7eh1WGwt7ddye38FBJL3lKghiW4/nati0tbmc62/Vbb2YLxVKO7XxIxc3U7qe1Xk33dy8kty9xhA1QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH//2Q==",
              title: "touskié formatique",
              description: "In this video I discuss 9 things I wish I knew before I started programming. Knowing these things would have made my journey in becoming a full-time iOS developer so much faster and easier. I hope this advice helps someone out there that's early in their career as a software developer.",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
            salaire:5.5,
           entrep: "Cayroll",
            type: "CDI"),
        
        Opp(imageName: "https://images.immediate.co.uk/production/volatile/sites/3/2023/03/Blue-Lock-06ed6cd.jpeg?resize=768,574",
              title: "9 Things I Wish I Knew When I Started Programming",
              description: "In this video I discuss 9 things I wish I knew before I started programming. Knowing these things would have made my journey in becoming a full-time iOS developer so much faster and easier. I hope this advice helps someone out there that's early in their career as a software developer.",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
            salaire:5.5,
           entrep: "Cayroll",
            type: "CDD"),
        
        Opp(imageName: "https://i.pinimg.com/originals/5f/60/34/5f60349f6b0980548907a7a81a8f3aed.jpg",
              title: "9 Things I Wish I Knew When I Started Programming",
              description: "In this video I discuss 9 things I wish I knew before I started programming. Knowing these things would have made my journey in becoming a full-time iOS developer so much faster and easier. I hope this advice helps someone out there that's early in their career as a software developer.",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
            salaire:5.5,
           entrep: "Cayroll",
            type: "CDD"),
        
        Opp(imageName: "https://i.pinimg.com/736x/a4/6f/91/a46f91eaa3420112e6c31b9a5030e4b8.jpg",
              title: "9 Things I Wish I Knew When I Started Programming",
              description: "In this video I discuss 9 things I wish I knew before I started programming. Knowing these things would have made my journey in becoming a full-time iOS developer so much faster and easier. I hope this advice helps someone out there that's early in their career as a software developer.",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
            salaire:5.5,
           entrep: "Cayroll",
            type: "CDD"),
        
        Opp(imageName: "https://scontent.ftun10-1.fna.fbcdn.net/v/t39.30808-6/342515741_573565118206414_2653962300371958831_n.jpg?stp=cp0_dst-jpg_e15_p160x160_q65&_nc_cat=105&ccb=1-7&_nc_sid=5f2048&_nc_ohc=sqm2MCsb4BcAX8ztDaS&_nc_ht=scontent.ftun10-1.fna&oh=00_AfBuSCBrkerZwmBrFRovG2PsOf9j139rDWKc9benFHjffQ&oe=656BF2C6",
              title: "9 Things I Wish I Knew When I Started Programming",
              description: "In this video I discuss 9 things I wish I knew before I started programming. Knowing these things would have made my journey in becoming a full-time iOS developer so much faster and easier. I hope this advice helps someone out there that's early in their career as a software developer.",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
            salaire:5.5,
           entrep: "Cayroll",
            type: "CDD"),
    ]
}
