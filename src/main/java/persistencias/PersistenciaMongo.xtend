package persistencias

import javax.persistence.Entity
import javax.persistence.DiscriminatorValue
import repositorio.mongo.RepoOrdenCompraMongo
import repositorio.mongo.RepoProveedorMongo
import repositorio.mongo.RepoProductoMongo

@Entity
@DiscriminatorValue("4")
class PersistenciaMongo extends ModoPersistencia {
	
	new() {
		modoPersistenciaDesc = "Mongo"
		esActivo = false
	}

	override getRepositorioOrdenCompra() {
		RepoOrdenCompraMongo.instance
	}

	override getRepositorioProductos() {
		RepoProductoMongo.instance
	}

	override getRepositorioProveedores() {
		RepoProveedorMongo.instance
	}
}
	
