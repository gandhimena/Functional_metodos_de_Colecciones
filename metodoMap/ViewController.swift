//
//  ViewController.swift
//  metodoMap
//
//  Created by spychatter mx on 1/10/18.
//  Copyright © 2018 spychatter. All rights reserved.
//
//Ventajas de los métodos map, filter, flatMap, reduce.
// - lejible
// - Ayuda a alcanzar la inmutabilidad
// - Ayuda a ser menos propenso a errores
// - Facil de testear
// - Facilita la ejecución concurrente

//Ejercicio
// Obtener la lista con los host de emails
// Numero de usuarios que usan cada host
// Media de edad de los usuarios
// Opcional. Lista ordenable

import UIKit

class ViewController: UIViewController {

	var userDataBase = JsonArray()
	var hosts = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		for db in UserConsumer.database{
			userDataBase.append(contentsOf: db)
		}
		
		for user in userDataBase{
			if let email = user["email"] as? String, let host = email.components(separatedBy: "@").last, !hosts.contains(host){
				hosts.append(host)
			}
		}
		
		print(hosts)
	}
	
	
	typealias HostInfo = (count:Int, age: Int)
	
	func getHostInfo(db: JsonArray, host:String) -> HostInfo {
		var count = 0
		var age = 0
		
		for user in db{
			if let email = user["email"] as? String, let userHost = email.components(separatedBy: "@").last, let userAge = user["age"] as? Int, userHost == host{
				count += 1
				age += userAge
			}
		}
		
		
		return HostInfo(count:count, age: age / count)
	}

	func result() -> [HostInfo]{
		var hostInfo = [HostInfo]()
		for host in hosts{
			hostInfo.append(getHostInfo(db: userDataBase, host: host))
		}
		
		
		for i in 0..<hosts.count{
			print("Hosts: \(hosts[i])")
			print("Count: \(hostInfo[i].count) users")
			print("Average Age: \(hostInfo[i].age) ")
		}
		
		return hostInfo
	}
	
	func zip(){
		let intNumbers = [1,2,3,4,5]
		let stringNumbers = ["one","two","three","four","five"]
		
		let numbersZiped = Swift.zip(stringNumbers, intNumbers)
		for (string, int) in numbersZiped{
			print("\(string): \(int)")
		}
	}
	
	

}

