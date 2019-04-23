package viewModel

import domain.OrdenCompra
import domain.Producto
import domain.Proveedor
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import rangoDeDatos.RangoCostos
import rangoDeDatos.RangoFechas
import repositorio.persistencias.RepoManagerOrdenesDeCompra
import repositorio.persistencias.RepoManagerProductos
import repositorio.persistencias.RepoManagerProveedores

@Accessors
@Observable
class ConsultarOrdenModel {

	RangoFechas rangoFechas = new RangoFechas
	RangoCostos rangoCostos = new RangoCostos
	List<Producto> productos
	Producto productoSeleccionado
	List<Proveedor> proveedores
	Proveedor proveedorSeleccionado
	List<OrdenCompra> resultados
	OrdenCompra ordenSeleccionado

	// ********************************************************
	// ** Acciones
	// ********************************************************
	def void search() {
		validarOrdenABuscar() // TODO
		resultados = getRepoOrdenDeCompra.search(productoSeleccionado, proveedorSeleccionado, rangoCostos.costoDesde,
		rangoCostos.costoHasta, rangoFechas.fechaDesde, rangoFechas.fechaHasta)
		this.limpiar()
		
	}
	
	def void limpiar(){
		rangoFechas = new RangoFechas
		rangoCostos = new RangoCostos
		productoSeleccionado = null
		proveedorSeleccionado = null
	}

	def void validarOrdenABuscar() {
		validarFechas()
		validarCostos()

	}

	def void validarFechas() {
		rangoFechas.validarFechaDesde
		rangoFechas.validarFechaHasta
		rangoFechas.validarRangoFechas
	}

	def void validarCostos() {
		rangoCostos.validarCostoDesde
		rangoCostos.validarCostoHasta
		rangoCostos.validarRangoCostos
	}

//TODO
	def getRepoOrdenDeCompra() {
		RepoManagerOrdenesDeCompra.instance.repoActivo
	}

	def getRepoProductos() {
		RepoManagerProductos.instance.repoActivo
	}

	def getRepoProveedores() {
		RepoManagerProveedores.instance.repoActivo
	}

}
