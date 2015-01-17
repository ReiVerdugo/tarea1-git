#************************************************************************
# Archivo : pregunta_2.rb 
# 
# Descripcion: Utilizando un diccionario de entrada, este programa
#              indica cuáles letras nunca aparecen repetidas de forma 
#              consecutiva.
#     
# Implementado: Lenguaje Ruby (version 2.1.2)
#  
# Autor: 
#          Reinaldo Verdugo   # carnet 10-10757
# 
#*************************************************************************/

#diccionario de simbolos que pertenecen al lenguaje

$consecutivas = {
  'A'          => /[Aa][Aa]/,
  'B'          => /[Bb][Bb]/,
  'C'          => /[Cc][Cc]/,
  'D'          => /[Dd][Dd]/,
  'E'          => /[Ee][Ee]/,
  'F'          => /[Ff][Ff]/,
  'G'          => /[Gg][Gg]/,
  'H'          => /[Hh][Hh]/,
  'I'          => /[Ii][Ii]/,
  'J'          => /[Jj][Jj]/,
  'K'          => /[Kk][Kk]/,
  'L'          => /[Ll][Ll]/,
  'M'          => /[Mm][Mm]/,
  'N'          => /[Nn][Nn]/,
  'O'          => /[Oo][Oo]/,
  'P'          => /[Pp][Pp]/,
  'Q'          => /[Qq][Qq]/,
  'R'          => /[Rr][Rr]/,
  'S'          => /[Ss][Ss]/,
  'T'          => /[Tt][Tt]/,
  'U'          => /[Uu][Uu]/,
  'V'          => /[Vv][Vv]/,
  'W'          => /[Ww][Ww]/,
  'X'          => /[Xx][Xx]/,
  'Y'          => /[Yy][Yy]/,
  'Z'          => /[Zz][Zz]/,
}




#********************************************************************************
# Nombre: Clase Lector
# Descripcion : Clase que se encargar de tomar la entrada e identificar cada 
#               una de las palabras contenidos en la misma. Se encarga de verificar,
#               haciendo uso del Hash 'consecutivas' cuales letras no aparecen 
#               repetidas.
#
# Atributos: 
#
# => :noRepetidas : Lista que contiene las letras que no aparecen repetidas
#
#
# => :input       : variable que contiene la entrada que esta siendo leida
#
#*******************************************************************************/

class Lector
    attr_accessor :noRepetidas    
    attr_reader :input

    # Metodo para inicializar los valores
    def initialize(input)
        @noRepetidas  = []
        @input = input
    end

    # Metodo que se encarga de ignorar los comentarios o espacios en blanco
    def ignore(length)
        return if length.eql? 0

        trh = @input[0 .. (length - 1)]
        @input = @input[length..@input.length]
        lineas = (trh + " ").lines.length - 1

    end

    # Metodo para leer la siguiente palabra
    def next_word
        @input =~ /\A(\s|(#.*\n)|\n)*/
        self.ignore($&.length)

        # Si ya no se consiguen mas palabras, se devuelve nil
        return nil if @input.empty?

        new_text = $&

        # Para cada una de las palabras se verifica con el Hash
        # si se coincide con alguna expresion regular, es decir,
        # con algunas letras de forma consecutivas
        $consecutivas.each do |key,value|
            if @input =~ value then

            else
                @noRepetidas << key
            end
        end

        self.ignore(new_text.length)
    end

    # Método para imprimir las letras no repetidas
    def imprimir
        @noRepetidas.each do |t|
            puts t
        end
    end
end

## Programa principal ########-------------------------------------------------

## Si recibimos una entrada en la línea de comando
if ARGV[0] != nil 
    lector = Lector.new(File::read(ARGV[0]))
    palabra = lector.next_word

    ## Mientras sigamos consiguiendo palabras, llamamos al método next_word
    while (palabra != nil)
        palabra = lector.next_word
    end

    puts "\nLas letras no repetidas en el diccionario recibido son:"
    puts lector.noRepetidas

## Si no recibimos entrada por la línea de comando
else
    puts "\nPor favor especifica en la linea de comando el nombre de algún"
    puts "archivo que contenga un diccionario con palabras asociadas\n"
    puts "Ejemplo: sowpods.txt"
end