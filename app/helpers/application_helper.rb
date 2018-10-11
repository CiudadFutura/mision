module ApplicationHelper

  def get_section(request)
    section = {}
    case request.path
      when '/productos'
        section = {
            :seccion => 'tienda',
            :titulo =>'',
            :subtitulo => ''
        }
      when '/faqs'
        section = {
            :seccion => 'preguntas',
            :titulo =>'',
            :subtitulo => ''
        }
      when '/dossiers'
        section = {
            :seccion => 'quees',
            :titulo =>'Organizada la vida es mejor',
            :subtitulo => 'No más ofertas engañosas ni perdida de tiempo'
        }
      when '/usuarios/sign_up'
        section = {
            :seccion => 'registro',
            :titulo =>'Ahorrá hasta un 40%',
            :subtitulo => 'Otra forma de consumo, lejos de abusos.'
        }
      else
        section = {
            :seccion => 'home',
            :titulo =>'Más barato, más fácil, más justo',
            :subtitulo => 'Productores y consumidores vinculados de forma directa, sin intermediarios'
        }
    end
    return section
  end

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-danger'
    when 'alert' then 'alert alert-danger'
    end
  end

end
