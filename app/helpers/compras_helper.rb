module ComprasHelper
  def get_cycle_image(text)
    img = ''
    if text.include?('D3')
      img = 'v2/oeste.png'
    end
    if text.include?('D1 y D4')
      img = 'v2/uno_cuatro.png'
    end
    if text.include?('D2 y D5')
      img = 'v2/dos_cinco.png'
    end
    if text.include?('D6')
      img = 'v2/centro.png'
    end
    if text.include?('Moreno')
      img = 'v2/moreno.png'
    end
    return img
  end
end
