//
//  SkeletonModelTests.swift
//  SpineTests
//
//  Created by Max Gribov on 26/01/2018.
//  Copyright © 2018 Max Gribov. All rights reserved.
//

import XCTest
@testable import Spine

class SkeletonModelTests: XCTestCase {
    
    //MARK: - Skeleton
    
    func testSkeletonModel() {

        //given
        let json = """
        {
            "hash": "5WtEfO08B0TzTg2mDqj4IHYpUZ4",
            "spine": "3.1.05",
            "width": 470.86,
            "height": 731.44,
            "fps": 29.5,
            "images": "./images/"
        }
        """.data(using: .utf8)!
        
        //when
        let skeleton = try? JSONDecoder().decode(SkeletonModel.self, from: json)

        //then
        if let skeleton = skeleton {
            
            XCTAssertEqual(skeleton.hash, "5WtEfO08B0TzTg2mDqj4IHYpUZ4")
            XCTAssertEqual(skeleton.spine, "3.1.05")
            XCTAssertEqual(skeleton.size.width, 470.86, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(skeleton.size.height, 731.44, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(skeleton.fps, 29.5, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(skeleton.path!, "./images/")
 
        } else {

            XCTFail("skeleton should not be nil")
        }
    }
    
    func testSkeletonModelOmitted() {
        
        //given
        let json = """
        {
            "hash": "5WtEfO08B0TzTg2mDqj4IHYpUZ4",
            "spine": "3.1.05",
            "width": 470.86,
            "height": 731.44
        }
        """.data(using: .utf8)!
        
        //when
        let skeleton = try? JSONDecoder().decode(SkeletonModel.self, from: json)
        
        //then
        if let skeleton = skeleton {
            
            XCTAssertEqual(skeleton.hash, "5WtEfO08B0TzTg2mDqj4IHYpUZ4")
            XCTAssertEqual(skeleton.spine, "3.1.05")
            XCTAssertEqual(skeleton.size.width, 470.86, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(skeleton.size.height, 731.44, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(skeleton.fps, 30.0, accuracy: CGFloat.ulpOfOne)
            XCTAssertNil(skeleton.path)
            
        } else {
            
            XCTFail("skeleton should not be nil")
        }
    }
    
    //MARK: - Bone
    
    func testBoneModel() {
        
        //given
        let json = """
        {
            "name": "back-foot-tip",
            "parent": "rear-foot",
            "length": 50.3,
            "rotation": -0.85,
            "x": 51.17,
            "y": 0.24,
            "transform": "noRotationOrReflection",
            "scaleX": 0.785,
            "scaleY": 0.785,
            "shearX": 0.21,
            "shearY": 0.97,
            "inheritScale": false,
            "inheritRotation": false,
            "color": "ff000dff",
        }
        """.data(using: .utf8)!
        
        //when
        let bone = try? JSONDecoder().decode(BoneModel.self, from: json)
        
        //then
        if let bone = bone {
            
            XCTAssertEqual(bone.name, "back-foot-tip")
            XCTAssertEqual(bone.parent, "rear-foot")
            XCTAssertEqual(bone.lenght, 50.3, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.rotation, -0.85, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.position.x, 51.17, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.position.y, 0.24, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.transform, .noRotationOrReflection)
            XCTAssertEqual(bone.scale.dx, 0.785, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.scale.dy, 0.785, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.shear.dx, 0.21, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.shear.dy, 0.97, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.inheritScale, false)
            XCTAssertEqual(bone.inheritRotation, false)
            XCTAssertEqual(bone.color.value, "ff000dff")
            
        } else {
            
            XCTFail("bone should not be nil")
        }
    }
    
    func testBoneModelOmitted() {
        
        //given
        let json = """
        {
            "name": "back-foot-tip"
        }
        """.data(using: .utf8)!
        
        //when
        let bone = try? JSONDecoder().decode(BoneModel.self, from: json)
        
        //then
        if let bone = bone {
            
            XCTAssertEqual(bone.name, "back-foot-tip")
            XCTAssertNil(bone.parent)
            XCTAssertEqual(bone.lenght, 0, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.transform, .normal)
            XCTAssertEqual(bone.position.x, 0, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.position.y, 0, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.rotation, 0, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.scale.dx, 1.0, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.scale.dy, 1.0, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.shear.dx, 0, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.shear.dy, 0, accuracy: CGFloat.ulpOfOne)
            XCTAssertEqual(bone.inheritScale, true)
            XCTAssertEqual(bone.inheritRotation, true)
            XCTAssertEqual(bone.color.value, "989898FF")
            
        } else {
            
            XCTFail("bone should not be nil")
        }
    }
    
    //MARK: - Slot
    
    func testSlotModel() {
        
        //given
        let json = """
        {
            "name": "upper_back_arm",
            "bone": "upper_back_arm",
            "attachment": "upper_back_arm",
            "color": "FF7F00FF",
            "dark": "F1F100FF",
            "blend": "additive"
        }
        """.data(using: .utf8)!
        
        //when
        let slot = try? JSONDecoder().decode(SlotModel.self, from: json)
        
        //then
        if let slot = slot {
            
            XCTAssertEqual(slot.name, "upper_back_arm")
            XCTAssertEqual(slot.bone, "upper_back_arm")
            XCTAssertEqual(slot.attachment, "upper_back_arm")
            XCTAssertEqual(slot.color.value, "FF7F00FF")
            XCTAssertEqual(slot.dark!.value, "F1F100FF")
            XCTAssertEqual(slot.blend, .additive)

        } else {
            
            XCTFail("slot should not be nil")
        }
    }
    
    func testSlotModelOmitted() {
        
        //given
        let json = """
        {
            "name": "upper_back_arm",
            "bone": "upper_back_arm"
        }
        """.data(using: .utf8)!
        
        //when
        let slot = try? JSONDecoder().decode(SlotModel.self, from: json)
        
        //then
        if let slot = slot {
            
            XCTAssertEqual(slot.name, "upper_back_arm")
            XCTAssertEqual(slot.bone, "upper_back_arm")
            XCTAssertNil(slot.attachment)
            XCTAssertEqual(slot.color.value, "FFFFFFFF")
            XCTAssertNil(slot.dark)
            XCTAssertNil(slot.blend)
            
        } else {
            
            XCTFail("slot should not be nil")
        }
    }
}
