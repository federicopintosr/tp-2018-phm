package repositorio.persistencias

import domain.Producto
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoProducto

@Observable
@Accessors
class RepoManagerProductos {

	static RepoManagerProductos instance

	List<RepoProducto> reposProductos = newArrayList

	RepoProducto repoActivo

	static def getInstance() {
		if (instance === null) {
			instance = new RepoManagerProductos()
		}
		return instance
	}

	new() {
		val modosPersistenciaActivos = RepoPersistencia.instance.getModosPersistenciaActivos
		modosPersistenciaActivos.forEach[modo|this.agregarModoPersistencia(modo.getRepositorioProductos)]
		repoActivo = RepoPersistencia.instance.getUltimoModoPersistenciaActivado.getRepositorioProductos 
	}

	def create(Producto _producto) {
		reposProductos.forEach[repo|repo.create(_producto)]
	}

	def update(Producto _producto) {
		reposProductos.forEach[repo|repo.update(_producto)]
	}

	def agregarModoPersistencia(RepoProducto nuevoRepositorio) {
		reposProductos.add(nuevoRepositorio)
		repoActivo = nuevoRepositorio
	}

}
