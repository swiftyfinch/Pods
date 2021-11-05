//
//  Sounds.swift
//  Pods
//
//  Created by Vyacheslav Khorkov on 05.11.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

func playBellSound() {
    _ = try? printShell("tput bel")
}
