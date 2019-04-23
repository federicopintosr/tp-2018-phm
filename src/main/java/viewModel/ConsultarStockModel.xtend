package viewModel

import domain.Producto
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import repositorio.interfaces.RepoProducto
import repositorio.persistencias.RepoManagerProductos

@Accessors
@Observable
class ConsultarStockModel {


	Producto productoSeleccionado
	List<Producto> resultados = getRepoProducto.allInstances()
	String descripcion = ""
	Integer stockMinimoABuscar 
	Integer stockMaximoABuscar 
	boolean soloDebajoStockMinimo = false

	// ********************************************************
	// ** Acciones
	// ********************************************************

	def void search() {
		validarStockABuscar()
		resultados = newArrayList //Esto lo hacemos por los problemas del binding de Arena con Mongo
		resultados = getRepoProducto.search(descripcion, stockMinimoABuscar, stockMaximoABuscar,soloDebajoStockMinimo)
		this.limpiar
	}
	
	def void validarStockABuscar() {
		validarStockNegativo(stockMinimoABuscar)
		validarStockNegativo(stockMaximoABuscar)
		validarRangoStock
	}
	
	def void limpiar(){
		descripcion = null
		stockMinimoABuscar = null
		stockMaximoABuscar = null
		
	}

	def  RepoProducto getRepoProducto() {
		RepoManagerProductos.instance.repoActivo
	}


	def void validarStockNegativo(Integer unStock) {
		if(unStock===null){
			return
		}
		if (stockNegativo(unStock)) {
			throw new UserException("Debe Ingresar Rangos de Stock Positivos")
		}
	}

	def void validarRangoStock(){
		if(stockMinimoABuscar===null||stockMaximoABuscar===null){
			return
		}
		if(stockMinimoABuscar>stockMaximoABuscar){
			throw new UserException("Debe Ingresar Rangos de Stock Validos")
		}
		
	}

	def stockNegativo(Integer unStock) {
		unStock.intValue < 0

	}
	def getProductoCompuestoSeleccionado(){
		repoProducto.searchById(getProductoSeleccionado)
		
	}

}
