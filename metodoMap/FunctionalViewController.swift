//
//  FunctionalViewController.swift
//  metodoMap
//
//  Created by spychatter mx on 1/12/18.
//  Copyright © 2018 spychatter. All rights reserved.
//
//== Funcion map ==. Nos soluciona el problema de transformar los elementos de una collección de una forma censilla.
//Esta funcion aplicada sobre un array. recibe una funcion y retorma un array del mismo tamaño que el original, y como elementos el resultado de aplicar la función sobre cada elemento. Map, no modifica la entrada original, sino crea una nueva.

//== Funcion filter ==
//Esta función aplicada sobre un array. recibe una funcion y retorna  un array coyos elementos satisfacen la condición impuesta por dicha funcion.

//== Funcion reduce ==
// Esta funcion aplicada sobre una colección. recibirá una funcion y un acumulador. El cual retornará una función del mismo tipo del acumulador, resultado de ir aplicando la función recibida sobre cada elemento del array y el acumulador que se reciba del paso anterior.

//== Funcion flatMap ==
// FlatMap desempaqueta matrices, metiendo todo en un solo array, también elimina de la lista los valores nulos.

//== funcion zip ==
//La funcion Zip es unir dos listas en una sola, es decir, va tomando cada elemento de una lista y envolviendolos en forma de tupla, para despues devolver todas las tuplas en otra lista pero juntas. Si una lista tiene mas elementos que la otra, éstas se descartan.

//== forEach ==
// La funcion forEach no retorna valor, su unica razon de ser es llamar a funciones que modifiquen el estado mutable.
// Este método también es un método de orden superior, osea que puede recibir una función como parametro, que dicha funcion no devuelve nada.

//== sort ==
//Esta función orden los elementos otorgados. Esto quiere decir que modificará el array original, lo cual tendría que ser una variable.

//== sorted ==
//Esta funcion devuelve un nuevo array con los elementos ordenados, por lo tanto el resultado se le puede asignar a una constante.


//Diferencia entre imperativo y funcional
//Las implementaciones imperativas son normalmente mas eficientes que las funcionales, pero depende de lo inteligente que sea el compilador.
//Las funcionales son mas reutilizables, robustas y paralelizables.





import UIKit

//Entendamos como funciona map


class FunctionalViewController: UIViewController{
	
	let userDataBase = UserConsumer.database.flatMap{$0}

	
	override func viewDidLoad() {
		super.viewDidLoad()
		_ = result()
		
	}
	
	typealias HostInfo = (count:Int, age: Int)
	
	func hostInfo(db: JsonArray) -> (String) -> HostInfo {
		return{ host in

			let result = db.reduce(HostInfo(count: 0,age:0)) { accumulator, user in
				guard let userHost = self.getHost(user: user), let userAge = user["age"] as? Int, userHost == host else{
						return accumulator
				}
				return (accumulator.count + 1, accumulator.age + userAge)
			}
			return HostInfo(count: result.count , age: result.age / result.count)
		}
	}
		
	func getHost(user: JsonObject) -> String?{
		return (user["email"] as? String)?.components(separatedBy: "@").last
	}
		
	func result(){
		
		let hosts: [String] = userDataBase
			.flatMap(getHost)
			.reduce([]) { accumulator, host in
				accumulator + (accumulator.contains(host) ? [] : [host])
			}
		
		let hostInfo: [HostInfo] = hosts.map(self.hostInfo(db: userDataBase))
		
		
		let hostsZiped = zip(hosts, hostInfo)
		
		
		hostsZiped
			// ((String, HostInfo), (String, HostInfo))
			.sorted{ $0.0 < $1.0 }
			.forEach(printHost)
		
		
		let numbers = ["1516156683", "1516156697", "1516156709", "1516156716", "1516156722", "1516156728"]
		print(numbers.sorted(by: < ))
		
	}
	
	func printHost(host: String, hostInfo:HostInfo){
		print("Hosts: \(host)")
		print(" - Count: \(hostInfo.count ) users")
		print(" - Average Age: \(hostInfo.age) ")
	}
	
}
