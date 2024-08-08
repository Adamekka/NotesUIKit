//
//  NewNoteDelegate.swift
//
//  Copyright © 2024 Adam Cvikl
//

@MainActor
protocol NewNoteDelegate: AnyObject {
    func new(_ note: String)
}
