package repositorio.interfaces

import domain.Producto
import domain.ProductoCompuesto
import java.util.List

interface RepoProducto extends Repositorio<Producto> {

	override List<Producto> allInstances()

	def List<Producto> search(String descripcionBuscada, Integer stockMinimoABuscar, Integer stockMaximoABuscar,
		boolean soloDebajoStockMinimo)

	def ProductoCompuesto searchById(Producto producto)

	def Producto searchProducto(Producto producto)
}
