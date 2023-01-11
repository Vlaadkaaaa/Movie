// ViewCellDelegate.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для делегата
protocol ViewCellDelegate: AnyObject {
    func showAlert(error: Error)
}
