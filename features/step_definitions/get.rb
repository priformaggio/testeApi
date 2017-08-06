############################ DADO ############################################
Dado(/^que eu faça um GET no endpoint filmes$/) do
  @get_filmes = HTTParty.get'http://swapi.co/api/films/?format=json'
end



############################ ENTAO ############################################
Entao(/^será exibido todos os títulos$/) do
	@results = JSON.parse(@get_filmes.body)

	@results['results'].each do |resultado|
   		puts resultado['title']
	end

	puts @get_filmes.code
    expect(@get_filmes.code).to eq 200
end

Entao(/^será exibido todos os títulos em que George Lucas e Rick McCallum trabalharam juntos$/) do

	@json = JSON.parse(@get_filmes.body)

    @json['results'].each do |resultado|
   		if ((resultado['director']  == "George Lucas") && (resultado['producer'].include? "Rick McCallum"))
			puts resultado['title']
		end
  	end
    
    puts @get_filmes.code
    expect(@get_filmes.code).to eq 200
end
