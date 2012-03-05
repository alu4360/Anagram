#!/usr/bin/env ruby
require 'optparse' #Carga una librería para hacer un análisis de la línea de comandos

  dictionary = "/usr/share/dict/words"

  OptionParser.new do |opts| #Construye un objeto parser, recibe un bloque. Se le pasa el objeto opts que va a ser el parser de la línea de comandos.

  opts.banner = "Usage: anagram [ options ] word..."

  opts.on("-d", "--dict path", String, "Path to dictionary") do |dict| #Opciones del parser. Requiere un argumento de la clase String. Tiene un descriptor para indicar de donde viene ese argumento. Si se usa -d en la línea de comandos, se ejecuta el bloque
  dictionary = dict
end

  opts.on("-h", "--help", "Show this message") do #Si se usa -h, se ejecuta esta opción
  puts opts #Se imprime el propio objeto parser. Muestra todas las opciones disponibles.
  exit
end

begin
  ARGV << "-h" if ARGV.empty? #Añadimos -h a ARGV si está vacío
  opts.parse!(ARGV) #Le pasamos el array de argumentos. Modifica el objeto.
  rescue OptionParser::ParseError => e #Captura una excepción, por si el array de argumentos tenía algún error.
    STDERR.puts e.message, "\n", opts #Mensaje de la excepción
    exit(-1)
  end
end

# convert "wombat" into "abmotw". All anagrams share a signature
def signature_of(word)
  word.unpack("c*").sort.pack("c*") #Separa los ASCII de los caracteres de word en formato de cero o más caracteres, los ordena y los vuelve a convertir en una cadena.
end

signatures = Hash.new #Crea un hash tal que cada elemento del hash, si no esta inicializado, se inicializa según el bloque.
File.foreach(dictionary) do |line| #Cogemos una línea
  word = line.chomp #Quita el retorno de carro final de la línea
  signature = signature_of(word) #Buscamos la firma de la palabra
  (signatures[signature] ||= []) << word #signatures es un hash, en el que empujamos word. El hash es <firma, array de anagramas>
end

ARGV.each do |word| #Recorre todas las palabras que no se han consumido de ARGV, se guardan en word
  signature = signature_of(word) #Calculamos la firma
  if signatures[signature] #Si tiene algo, volcamos todo el array de anagramas
    puts "Anagrams of #{word}: #{signatures[signature].join(', ')}"
  else
    puts "No anagrams of #{word} in #{dictionary}"
  end
end


