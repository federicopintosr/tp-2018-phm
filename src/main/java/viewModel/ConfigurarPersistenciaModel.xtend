package viewModel

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import persistencias.ModoPersistencia
import repositorio.persistencias.RepoPersistencia

@Accessors
@Observable
class ConfigurarPersistenciaModel {
		List<ModoPersistencia> modosPersistenciaInactivos = getRepoPersistencia().getModosPersistenciaInactivos
		List<ModoPersistencia> modosPersistenciaActivos = getRepoPersistencia().getModosPersistenciaActivos
		ModoPersistencia modoPersistenciaSeleccionado = null
	
	def RepoPersistencia getRepoPersistencia(){
		RepoPersistencia.instance
	}
	
	def void agregarPersistencia(){
		modoPersistenciaSeleccionado.activar
		getRepoPersistencia().update(modoPersistenciaSeleccionado)
		modosPersistenciaInactivos = getRepoPersistencia().getModosPersistenciaInactivos
		modosPersistenciaActivos = getRepoPersistencia().getModosPersistenciaActivos
	}
	
}