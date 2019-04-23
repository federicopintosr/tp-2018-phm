package runnable

import domain.ItemOrdenCompra
import domain.ItemProducto
import domain.OrdenCompra
import domain.Producto
import domain.ProductoCompuesto
import domain.Proveedor
import java.time.LocalDate
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import persistencias.PersistenciaGrafos
import persistencias.PersistenciaMemoria
import persistencias.PersistenciaSQL
import repositorio.persistencias.RepoManagerOrdenesDeCompra
import repositorio.persistencias.RepoManagerProductos
import repositorio.persistencias.RepoManagerProveedores
import repositorio.persistencias.RepoPersistencia
import persistencias.PersistenciaMongo

class ProductosBootstrap extends CollectionBasedBootstrap {


	override run() {
		initModosPersistencia
	}

	def void initModosPersistencia() {
		RepoPersistencia.instance.createIfNew(new PersistenciaMemoria())
		RepoPersistencia.instance.createIfNew(new PersistenciaSQL())
		RepoPersistencia.instance.createIfNew(new PersistenciaGrafos())
		RepoPersistencia.instance.createIfNew(new PersistenciaMongo())
	}

	static def boolean dataBaseVacia() {
		var repoProducto=RepoManagerProductos.instance
		repoProducto.repoActivo.allInstances.isEmpty
	}

	 static def void cargarBase() {
		if (dataBaseVacia) {
			initFixtureDatos
		}
	}
	
	static def void initFixtureDatos() {
		
		/**
		 * REPOSITORIOS
		 */
		val repoOrdenDeCompra = RepoManagerOrdenesDeCompra.instance
		val repoProveedor = RepoManagerProveedores.instance
		val repoProducto = RepoManagerProductos.instance


		/**
		 * PRODUCTOS
		 */
		var ProductoCompuesto Bastidor
		var Producto Pirufio
		var Producto Tornoplete
		var Producto Velcro
		var Producto Aluminio

		/**
		 * ITEMS PRODUCTOS
		 */
		var ItemProducto ItemP1
		var ItemProducto ItemP2
		var ItemProducto ItemP3
		var ItemProducto ItemP4
		
		
		/**
		 * ITEMS OC
		 */
		var ItemOrdenCompra ItemO1
		var ItemOrdenCompra ItemO2
		var ItemOrdenCompra ItemO3
		var ItemOrdenCompra ItemO4

		/**
		 * PROVEEDORES
		 */
		var Proveedor Molinari
		var Proveedor Acevedo
		var Proveedor AutoNorte

		/**
		 * ORDENES DE COMPRAS
		 */
		var OrdenCompra Orden1
		var OrdenCompra Orden2


		/**
		 * INSTANCIACION 
		 * PRODUCTOS
		 */
		Bastidor = new ProductoCompuesto
		Pirufio = new Producto
		Tornoplete = new Producto
		Velcro = new Producto
		Aluminio = new Producto

		Pirufio.setStockAct(40)
		Pirufio.setDescripcion("Pirufio")
		Pirufio.setStockMin(5)
		Pirufio.setStockMax(50)
		Pirufio.setCosto(50)

		Tornoplete.setCosto(200)
		Tornoplete.setStockAct(30)
		Tornoplete.setDescripcion("Tornoplete")
		Tornoplete.stockMax = 100
		Tornoplete.stockMin = 40

		Velcro.descripcion = "Velcro Laminado"
		Velcro.costo = 222.22
		Velcro.stockAct = 22
		Velcro.stockMax = 300
		Velcro.stockMin = 100

		Aluminio.descripcion = "Aluminio SAE12854"
		Aluminio.costo = 1986.22
		Aluminio.stockAct = 22
		Aluminio.stockMax = 31
		Aluminio.stockMin = 7

		ItemP1 = new ItemProducto
		ItemP2 = new ItemProducto
		ItemP3 = new ItemProducto
		ItemP4 = new ItemProducto
		ItemO1 = new ItemOrdenCompra
		ItemO2 = new ItemOrdenCompra
		ItemO3 = new ItemOrdenCompra
		ItemO4 = new ItemOrdenCompra

		ItemP1.cantidad = 1
		ItemP1.producto = Velcro

		ItemP2.cantidad = 2
		ItemP2.producto = Aluminio

		ItemP3.cantidad = 3
		ItemP3.producto = Pirufio

		ItemP4.cantidad = 4
		ItemP4.producto = Tornoplete
		
		Bastidor.setDescripcion("Bastidor")
		Bastidor.stockMax = 100
		Bastidor.stockMin = 1
		Bastidor.setStockAct(5)

		Bastidor.setListaDeProductos = #[ItemP1, ItemP2]

		/**
		 * INSTANCIACION 
		 * ORDENES DE COMPRA
		 */
		ItemO1.cantidad = 1
		ItemO1.producto = Velcro

		ItemO2.cantidad = 2
		ItemO2.producto = Aluminio

		ItemO3.cantidad = 3
		ItemO3.producto = Pirufio

		ItemO4.cantidad = 4
		ItemO4.producto = Tornoplete

		/**
		 * INSTANCIACION 
		 * PROVEEDORES
		 */
		Molinari = new Proveedor
		Acevedo = new Proveedor
		AutoNorte = new Proveedor

		Molinari.descripcion = "Molinari"

		Acevedo.descripcion = "Acevedo Hnos."

		AutoNorte.descripcion = "Auto Norte"

		/**
		 * INSTANCIACION 
		 * ORDENES DE COMPRAS
		 */
		Orden1 = new OrdenCompra
		Orden2 = new OrdenCompra

		Orden1.fecha = LocalDate.now.minusYears(2)
		Orden1.proveedor = Molinari
		Orden1.listaDeProductos = #[ItemO1, ItemO2]
		Orden1.costo

		Orden2.fecha = LocalDate.now.minusYears(10)
		Orden2.proveedor = Acevedo
		Orden2.listaDeProductos = #[ItemO3, ItemO4]
		Orden2.costo


		/**
		 * AGREGAR OBJETOS DE DOMNIO 
		 * A LOS REPOSITORIOS CORRESPONDIENTES
		 */
		repoProducto.create(Pirufio)
		repoProducto.create(Tornoplete)
		repoProducto.create(Velcro)
		repoProducto.create(Aluminio)
		repoProducto.create(Bastidor)

		repoProveedor.create(Molinari)
		repoProveedor.create(Acevedo)
		repoProveedor.create(AutoNorte)

		repoOrdenDeCompra.create(Orden1)
		repoOrdenDeCompra.create(Orden2)
		//TODO
	}

}
