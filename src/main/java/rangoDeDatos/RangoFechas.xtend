package rangoDeDatos

import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
class RangoFechas {
	LocalDate fechaDesde
	LocalDate fechaHasta

	def validarRangoFechas() {
		if(fechaDesde===null||fechaHasta===null){return}
		if (!fechaDesdeMenorQueFechaHasta) {
			throw new UserException("Se Ingreso un Rango de Fechas Incorrecto")
		}
	}

	def fechaDesdeMenorQueFechaHasta() {
		fechaDesde < fechaHasta
	}
	
	def algunaFechaEsNull(){
		fechaDesde===null||fechaHasta===null
	}

	def fechaSuperiorALaActual(LocalDate unaFecha) {
		unaFecha > LocalDate.now
	}

	def validarFecha(LocalDate unaFecha, String nombreFecha) {
		if (unaFecha===null){return}
		if (fechaSuperiorALaActual(unaFecha)) {
			throw new UserException("La Fecha " + nombreFecha + " es superior a la Actual")
		}
	}
	def validarFechaDesde(){
		validarFecha(fechaDesde,"Desde")
	}
	
	def validarFechaHasta(){
		validarFecha(fechaHasta,"Hasta")
	}

	def setFechaDesde(LocalDate unaFecha) {
		fechaDesde = unaFecha
		validarFechaDesde()
	}

	def setFechaHasta(LocalDate unaFecha) {
		fechaHasta = unaFecha
		validarFechaHasta()
	}

}
