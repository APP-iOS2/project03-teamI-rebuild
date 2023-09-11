//
//  DevStore.swift
//  TicketLion_Comsumer
//
//  Created by J on 2023/09/06.
//

import Foundation

class DevStore: ObservableObject {
    @Published var pm: [Dev] = []
    @Published var consumer1: [Dev] = []
    @Published var consumer2: [Dev] = []
    @Published var consumer3: [Dev] = []
    @Published var admin: [Dev] = []
    
    init() {
        pm = [
            Dev(name: "김종찬", introduction: "여주 광대", imageURL: "https://cdn.discordapp.com/attachments/1143375923832422510/1148868698019467305/Patrick.jpeg", informationURL: "https://appschool3-ios.github.io/iOS-XC-11.html")
        ]
        
        consumer1 = [
            Dev(name: "남현정", introduction: "양천구 물주먹", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStXyGc1FomidCBT2JJ9tgkHHylM61iaS0TQSAkxWDT39TH--aH8sRfFqYIZPBJosh9hPQ&usqp=CAU", informationURL: "https://appschool3-ios.github.io/iOS-XC-16.html"),
            Dev(name: "이재승", introduction: "미정", imageURL: "https://i.namu.wiki/i/y7qTOOIL6nIa2cXybk511OASqwAGMgZiNjh6CtErz0ust7MPJaztzSYiypYevehQOjdJc-TQvTctUk7N629V7A.webp", informationURL: "https://appschool3-ios.github.io/iOS-XC-58.html"),
            Dev(name: "윤진영", introduction: "은평구 피바다", imageURL: "https://cdn.discordapp.com/attachments/1148869731705704541/1148869824169128036/2023-09-06_3.37.19.png", informationURL: "https://appschool3-ios.github.io/iOS-XC-51.html"),
            Dev(name: "주진형", introduction: "농심 너구리", imageURL: "https://cdn.discordapp.com/attachments/1143375923832422510/1148866857135243284/2EE951F5-69EE-4EB2-8098-29FC360FB956_1_105_c.jpeg", informationURL: "https://appschool3-ios.github.io/iOS-XC-74.html"),
        ]
        
        consumer2 = [
            Dev(name: "원강묵", introduction: "몸뚱아리 왼팔", imageURL: "https://i.namu.wiki/i/y7qTOOIL6nIa2cXybk511OASqwAGMgZiNjh6CtErz0ust7MPJaztzSYiypYevehQOjdJc-TQvTctUk7N629V7A.webp", informationURL: "https://appschool3-ios.github.io/iOS-XC-46.html"),
            Dev(name: "정석호", introduction: "몸뚱아리 오른팔", imageURL: "https://i.namu.wiki/i/y7qTOOIL6nIa2cXybk511OASqwAGMgZiNjh6CtErz0ust7MPJaztzSYiypYevehQOjdJc-TQvTctUk7N629V7A.webp", informationURL: "https://appschool3-ios.github.io/iOS-XC-69.html"),
            Dev(name: "한아리", introduction: "몸뚱아리", imageURL: "https://i.namu.wiki/i/y7qTOOIL6nIa2cXybk511OASqwAGMgZiNjh6CtErz0ust7MPJaztzSYiypYevehQOjdJc-TQvTctUk7N629V7A.webp", informationURL: "https://appschool3-ios.github.io/iOS-XC-78.html"),
        ]
        
        consumer3 = [
            Dev(name: "김윤우", introduction: "멋쟁이 개발자", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIuQiVt0JKNQm1EyeEVOzeJ7wwM3vRG1lTtQ&usqp=CAU", informationURL: "https://appschool3-ios.github.io/iOS-XC-09.html"),
            Dev(name: "유재희", introduction: "흠냐...", imageURL: "https://i.namu.wiki/i/y7qTOOIL6nIa2cXybk511OASqwAGMgZiNjh6CtErz0ust7MPJaztzSYiypYevehQOjdJc-TQvTctUk7N629V7A.webp", informationURL: "https://appschool3-ios.github.io/iOS-XC-47.html"),
            Dev(name: "이승준", introduction: "내가 짱이야 내가 최고야", imageURL: "https://3.gall-img.com/tdgall/files/attach/images/82/374/658/215/9e57e9358d3082c73c2ae54b374f76a9.jpg", informationURL: "https://appschool3-ios.github.io/iOS-XC-55.html"),
        ]
        admin = [
            Dev(name: "나예슬", introduction: "즐겁게 살자", imageURL: "https://cdn.discordapp.com/attachments/1143375923832422510/1148871510753296435/yseul.png", informationURL: "https://appschool3-ios.github.io/iOS-XC-15.html"),
            Dev(name: "선아라", introduction: "고양이 방석", imageURL: "https://cdn.discordapp.com/attachments/1143375923832422510/1148868191909580880/image.png", informationURL: "https://appschool3-ios.github.io/iOS-XC-35.html"),
            Dev(name: "임병구", introduction: "미정", imageURL: "https://i.namu.wiki/i/y7qTOOIL6nIa2cXybk511OASqwAGMgZiNjh6CtErz0ust7MPJaztzSYiypYevehQOjdJc-TQvTctUk7N629V7A.webp", informationURL: "https://appschool3-ios.github.io/iOS-XC-62.html"),
            Dev(name: "최세근", introduction: "미정", imageURL: "https://i.namu.wiki/i/y7qTOOIL6nIa2cXybk511OASqwAGMgZiNjh6CtErz0ust7MPJaztzSYiypYevehQOjdJc-TQvTctUk7N629V7A.webp", informationURL: "https://appschool3-ios.github.io/iOS-XC-75.html"),
        ]
    }
    
}
