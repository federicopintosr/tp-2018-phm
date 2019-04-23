package repositorio.persistencias

import domain.Proveedor
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import repositorio.interfaces.RepoProveedor

@Accessors
class RepoManagerProveedores {
	
	static RepoManagerProveedores instance
	
	List<RepoProveedor> reposProveedores = newArrayList

	RepoProveedor repoActivo

	static def getInstance() {
		if (instance === null) {
			instance = new RepoManagerProveedores()
		}
		return instance
	}

	new (){
		val modosPersistenciaActivos = RepoPersistencia.instance.getModosPersistenciaActivos
		modosPersistenciaActivos.forEach[modo | this.agregarModoPersistencia(modo.getRepositorioProveedores)]
		repoActivo = RepoPersistencia.instance.getUltimoModoPersistenciaActivado.getRepositorioProveedores
	}

	def create (Proveedor _proveedor){
		reposProveedores.forEach[ repo | repo.create(_proveedor)]
	}

	def agregarModoPersistencia(RepoProveedor nuevoRepositorio){
		reposProveedores.add(nuevoRepositorio)
		repoActivo = nuevoRepositorio
	}
}
