module Admin
  class UiComponentsController < ApplicationController

    def index
      @page_header_links = [
        {:title => 'Home', :href => '#home'},
      ]
      @section_header_breadcrumbs = [
        "Home",
        "Componentes",
      ]
      @section_header_links = [
        {:title => 'Cancelar', :href => '#'},
        {:title => 'Guardar Cambios', :href => '#'},
      ]
      @neighbor_card = {
        :name => 'Villa 20',
        :updated => '27/12/2017',
        :completed => '20',
      }
      @section_footer_link_left = {:title => 'Link a la izquierda', :href => '#'}
      @section_footer_link_right = {:title => 'Link a la derecha', :href => '#'}
      @description_text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Labore repellendus voluptatem nobis vel quo a fugit rerum velit obcaecati officia necessitatibus, aspernatur pariatur repudiandae saepe neque non blanditiis. Omnis, reprehenderit!"
      @section_header_buttons = [
        {:title => 'Cargar Documento'},
      ]
      @person_card = {
        :name => 'Gustavo Pavone',
        :type => 'Vecino',
        :image_url => 'http://i.pravatar.cc/45',
      }
      @documents_list = [
        {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
        {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
        {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
        {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      ]
      @documents_list_button = [
        {:title => 'Cargar Documento'},
      ]
    end
  end
end
