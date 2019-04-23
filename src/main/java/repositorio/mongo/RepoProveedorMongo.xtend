package repositorio.mongo

import domain.Proveedor
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoProveedor

@Accessors
@Observable
class RepoProveedorMongo extends RepoDefaultMongo<Proveedor> implements RepoProveedor {

	static RepoProveedorMongo instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoProveedorMongo()
		}
		return instance
	}

//TODO definimos este método aunque no se actualicen los proveedores por sistema
	override defineUpdateOperations(Proveedor proveedor) {
		val operations = ds.createUpdateOperations(entityType)
		operations.set("descripcion", proveedor.descripcion)
	}

	override getEntityType() {
		typeof(Proveedor)
	}

}
