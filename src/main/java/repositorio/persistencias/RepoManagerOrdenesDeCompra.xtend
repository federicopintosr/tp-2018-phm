package repositorio.persistencias

import domain.OrdenCompra
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import repositorio.interfaces.RepoOrdenCompra

@Accessors
class RepoManagerOrdenesDeCompra {
	
	static RepoManagerOrdenesDeCompra instance
	
	List<RepoOrdenCompra> reposOrdenesDeCompra = newArrayList  

	RepoOrdenCompra repoActivo 

	static def getInstance() {
		if (instance === null) {
			instance = new RepoManagerOrdenesDeCompra()
		}
		return instance
	}
	
	new (){
		val modosPersistenciaActivos = RepoPersistencia.instance.getModosPersistenciaActivos
		modosPersistenciaActivos.forEach[modo | this.agregarModoPersistencia(modo.getRepositorioOrdenCompra)]
		repoActivo = RepoPersistencia.instance.getUltimoModoPersistenciaActivado.getRepositorioOrdenCompra
		}
	
	def create (OrdenCompra _ordenCompra){
		reposOrdenesDeCompra.forEach[ repo | repo.create(_ordenCompra)]
	}
	
	def void agregarModoPersistencia(RepoOrdenCompra nuevoRepositorio){
		reposOrdenesDeCompra.add(nuevoRepositorio)
		repoActivo = nuevoRepositorio
	}
}
