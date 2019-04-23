package repositorio.neo4j

import domain.Proveedor
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoProveedor

@Accessors
@Observable
class RepoProveedorGrafos extends RepoDefaultGrafos<Proveedor> implements RepoProveedor{
	
	static RepoProveedorGrafos instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoProveedorGrafos()
		}
		return instance
	}
	
	
	override create(Proveedor _proveedor) {
		session.save(_proveedor)
	}
	
	override update(Proveedor t) {
	
	}
	
	override allInstances() {
		return new ArrayList(session.loadAll(typeof(Proveedor), PROFUNDIDAD_BUSQUEDA_LISTA))
	}
	
}
