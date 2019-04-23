package repositorio.memoria

import domain.Proveedor
import org.apache.commons.collections15.Predicate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoProveedor

@Accessors
@Observable
class RepoProveedorMemoria extends CollectionBasedRepo<Proveedor> implements RepoProveedor {

	static RepoProveedorMemoria instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoProveedorMemoria()
		}
		return instance
	}

	override getEntityType() {
		typeof(Proveedor)
	}

	override def Predicate<Proveedor> getCriterio(Proveedor example) {
		null
	}

	override createExample() {
		new Proveedor
	}

}
