package rangoDeDatos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
class RangoCostos {

	Double costoDesde 
	Double costoHasta 

	new() {
	}

	def validarRangoCostos() {
		if (algunCostoEsNull){return}
		if (!costoDesdeMenorQueCostoHasta) {
			throw new UserException("Se Ingreso un Rango de Costo Incorrecto")
		}
	}

	def algunCostoEsNull() {
		costoDesde === null || costoHasta === null
	}

	def costoDesdeMenorQueCostoHasta() {
		costoDesde < costoHasta
	}

	def validarUnCosto(double unCosto) {
		unCosto >= 0
	}

	def validarCosto(Double unCosto, String nombreCosto) {
		if(unCosto===null){return}
		if (!validarUnCosto(unCosto)) {
			throw new UserException("El Costo " + nombreCosto + " es invalido")
		}
	}

	def validarCostoDesde() {
		validarCosto(costoDesde, "Desde")
	}

	def validarCostoHasta() {
		validarCosto(costoHasta, "Hasta")
	}

	def void setCostoDesde(double unCosto) {
		validarCosto(costoDesde, "Desde")
		costoDesde = unCosto
	}

	def void setCostoHasta(double unCosto) {
		validarCosto(costoHasta, "Hasta")
		costoHasta = unCosto
	}

	def getCostoDesde() {
		costoDesde
	}

	def getCostoHasta() {
		costoHasta
	}
}
