package repositorio.mySQL

import domain.Proveedor
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoProveedor

@Accessors
@Observable
class RepoProveedorMySql extends RepoDefault<Proveedor> implements RepoProveedor  {
	
	static RepoProveedorMySql instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoProveedorMySql()
		}
		return instance
	}
	
	override getEntityType() {
		typeof(Proveedor)
	}

}
