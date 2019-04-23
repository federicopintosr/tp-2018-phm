package ui

import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import persistencias.ModoPersistencia
import viewModel.ConfigurarPersistenciaModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class ConfiguracionPersistenciaWindow extends Dialog<ConfigurarPersistenciaModel> {
	
	new(WindowOwner parent, ConfigurarPersistenciaModel model) {
		super(parent, model)
		title = defaultTitle
	}
	
	def defaultTitle() {
		"Configuracion de Persistencia"
	}
	
	override protected addActions(Panel actionsPanel) {
	}
	
	override protected createFormPanel(Panel panel) {
		val panelHorizontalTextBox2 = new Panel(panel).layout = new HorizontalLayout
		crearSelectorYBotonAgregar(panelHorizontalTextBox2)
		val panelVertical = new Panel(panel).layout = new VerticalLayout
		crearTabla(panelVertical)
		botonVolver(panelVertical)
	}


	def crearSelectorYBotonAgregar(Panel panel){
			new Label(panel).text = "Componente: "
			new Selector<ModoPersistencia>(panel) => [
			value <=> "modoPersistenciaSeleccionado"
			val propiedadModoPersistencia = bindItems(new ObservableProperty("modosPersistenciaInactivos"))
			propiedadModoPersistencia.adaptWith(typeof(ModoPersistencia), "modoPersistenciaDesc") 
			width = 250
		]
		
		new Button(panel) => [
			caption = "Agregar"
			onClick([|modelObject.agregarPersistencia])
		]
	}
	
	def protected crearTabla(Panel panel) {
			val tablaModosActivos = new Table<ModoPersistencia>(panel, typeof(ModoPersistencia)) => [
			items <=> "modosPersistenciaActivos"
			numberVisibleRows = 5
		]
		this.crearColumnasTabla(tablaModosActivos)
	}

	def void crearColumnasTabla(Table<ModoPersistencia> table) {
			new Column<ModoPersistencia>(table) => [
			title = "Componentes activos"
			fixedSize = 250
			bindContentsToProperty("modoPersistenciaDesc")
		]
		
	}
	def botonVolver(Panel panel){
		new Button(panel) => [
			caption = "Volver"
			onClick([|accept])
			]
	}
	
}

	
