//
//  UserConsumer.swift
//  metodoMap
//
//  Created by spychatter mx on 1/10/18.
//  Copyright © 2018 spychatter. All rights reserved.
//

import Foundation

public typealias JsonObject = [String: AnyObject]
public typealias JsonArray = [JsonObject]

public class UserConsumer{
	
	static func json(path: String) -> JsonArray{
		guard let path = Bundle.main.path(forResource: path, ofType: "json"),
			let jsonData = NSData(contentsOfFile: path),
			let jsonResult = try? JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! JsonArray else {
			return JsonArray()
		}
	
		return jsonResult
	}
	
	public static var database: [JsonArray] {
		//[[String:AnyObject],[String:AnyObject],[String:AnyObject]]
		return [json(path: "Database1"), json(path: "Database2"), json(path: "Database3")]
	}
	
	
}
