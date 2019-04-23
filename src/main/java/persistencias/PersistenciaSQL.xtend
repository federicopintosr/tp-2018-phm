package persistencias

import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import repositorio.mySQL.RepoOrdenCompraMySql
import repositorio.mySQL.RepoProductoMySql
import repositorio.mySQL.RepoProveedorMySql

@Entity
@DiscriminatorValue("1")
class PersistenciaSQL extends ModoPersistencia {

	new() {
		modoPersistenciaDesc = "Relacional"
		esActivo = false

	}

	override getRepositorioOrdenCompra() {
		RepoOrdenCompraMySql.instance
	}

	override getRepositorioProductos() {
		RepoProductoMySql.instance
	}

	override getRepositorioProveedores() {
		RepoProveedorMySql.instance
	}
}
