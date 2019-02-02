module ComprasHelper
  def get_cycle_image(text)
    img = ''
    if text.include?('Distrito 3')
      img = 'v2/oeste.png'
    end
    if text.include?('Distritos 1 y 4')
      img = 'v2/uno_cuatro.png'
    end
    if text.include?('Distritos 2 y 5')
      img = 'v2/dos_cinco.png'
    end
    if text.include?('Distrito 6')
      img = 'v2/centro.png'
    end
    if text.include?('Moreno')
      img = 'v2/moreno.png'
    end
    return img
  end
end
