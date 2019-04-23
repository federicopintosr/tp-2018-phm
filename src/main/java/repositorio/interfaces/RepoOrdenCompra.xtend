package repositorio.interfaces

import domain.OrdenCompra
import domain.Producto
import domain.Proveedor
import java.time.LocalDate
import java.util.List

interface RepoOrdenCompra extends Repositorio<OrdenCompra> {

	def List<OrdenCompra> search(Producto productoBuscado, Proveedor proveedorBuscado, Double costoMinABuscar,
		Double costoMaxABuscar, LocalDate fechaMinABuscar, LocalDate fechaMaxABuscar)

}
