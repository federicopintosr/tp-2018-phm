package repositorio.mongo

import com.mongodb.MongoClient
import domain.ItemProducto
import domain.Producto
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.query.UpdateOperations
import repositorio.interfaces.Repositorio
import domain.OrdenCompra
import domain.ItemOrdenCompra
import domain.Proveedor

abstract class RepoDefaultMongo<T> implements Repositorio<T> {
	static protected Datastore ds
	static Morphia morphia

	new() {
		if (ds === null) {
			val mongo = new MongoClient("localhost", 27017)
			morphia = new Morphia => [
				 map(typeof(Producto))
				.map(typeof(ItemProducto))
				.map(typeof(OrdenCompra))
				.map(typeof(ItemOrdenCompra))
				.map(typeof(Proveedor))
				ds = createDatastore(mongo, "carp")
				ds.ensureIndexes
			]
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
		}
	}

	override void update(T t) {
		ds.update(t, this.defineUpdateOperations(t))
	}

	abstract def UpdateOperations<T> defineUpdateOperations(T t)

	override create(T t) {
		ds.save(t)
		
	}

	override List<T> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	abstract def Class<T> getEntityType()
	
}