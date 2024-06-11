//
// DropDownData.swift
//
// Created by Hussein Anwar.
//
import Foundation

struct DropDownData:Identifiable,Equatable,Hashable{
    let _id = UUID()
    let id:Int
    var title:String = ""
    var icon:String = ""
    var isSelected: Bool = false
    var value: String = ""
}
