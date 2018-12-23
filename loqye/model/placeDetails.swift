//
//  placeDetails.swift
//  loqye
//
//  Created by youssef on 12/21/18.
//  Copyright © 2018 youssef. All rights reserved.
//



/*
 
 {
 "data": {
 "id": 3,
 "title": "قصر افراح اللؤلؤة",
 "details": "قاعة اللؤلؤة للافراح و المناسبات \r\nتحتوي القاعة على ثلاث قاعات :\r\nقاعة الطعام العدد الاستيعابي لها 500 شخص عدد الطاولات 50 طاولة .\r\nقاعة الضيوف للرجال العدد الاستيعابها لها 1000 شخص .\r\nقاعة الافراح للنساء العدد الاستيعابي لها 400 شخص عدد الطاولات 50 طاولة .\r\nكما يوجد جناح خاص للعروس مكون من غرفتين .\r\nإدارة القاعة على اتم الاستعداد لتجهيز القاعة بالكامل بمبلغ إضافي و من الخدمات :\r\n- كوشة , إضاءة ليزر بخار , دي جي , مفتشة و منظمة للحفل ,\r\n- خدمات الضيافة و تجهيز البوفيه للرجال و النساء .",
 "price": 15000,
 "image": "SUSG1.background.jpg",
 "area": "١٠٠ متر مربع",
 "availiable": "طوال ايام الاسبوع",
 "address": "سكاكا - جدة - الرياض - الطريق الريع",
 "workers": "١٠ عمال بالقاعة",
 "rooms": "٨ غرف بكل طابق",
 "chairs": "٥٠ طاولة كل طاولة بها ٤ كراسي",
 "rating": 0,
 "imagesPath": "https://luqia.net/upload/places/",
 "images": [
 {
 "place_id": 3,
 "image": "0AkaO.app1.jpg"
 },
 {
 "place_id": 3,
 "image": "AidNI.app1.jpg"
 }
 ]
 },
 "status": "done"
 }
 
 
 */

import Foundation

struct placeDetails {
    
    var id :Int
    var title: String
    var details: String
    var price : Int
    var area : String
    var availiable: String
    var rooms: String
    var workers : String
    var address : String
    var chairs : String
    var rating :String
    var image : String
    var imagePath : String
}
