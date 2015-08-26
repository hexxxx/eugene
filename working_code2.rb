          # Fetches SEQUENCE from GenBank
          # Sets ID (temporary. Will have user input the ID or name in the simple_form on proteins#new)
          accession = 296334

          # need to get the sequence
          # then convert from DNA to RNA,
          # then chunk the RNA
          # convert to AAs
          # calculate MW from hash



          def conversion
            accession()


          # Defines the URI for eSearch
          uri = URI('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi')

          # Defines params for dynamic GET request for eSearch
          def accessionSearch(accession)
            params = { :db => "nucleotide", :id => accession, :sort => "relevance" }
            uri.query = URI.encode_www_form(params)
            response = Net::HTTP.get_response(uri)
            seq = response.body if response.is_a?(Net::HTTPSuccess)
          end

            # seq4 = seq3.join.delete("\n")

          # Defines the URI
          # Defines params for dynamic GET request
          # bobby recommends httparty
          def accession(accession)
            uri = URI('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi')
            params = { :db => "protein", :id => accession, :rettype => "fasta", :retmode => "text"}
            uri.query = URI.encode_www_form(params)
            response = Net::HTTP.get_response(uri)
            seq = response.body if response.is_a?(Net::HTTPSuccess)
          end

          def convertDNA(seq)
            seqArray = []
            seq.split(/\n/).each do |i|
              seqArray << /\A((?!>.*).)*\z/.match(i)
            end
            seq = seqArray.join
          end

          def convertyThyUr
            # Replaces Ts with Us
            seq.gsub!("T","U")
          end

          # Calls the appropriate residue from the hash
          def convertAA(seq)
            i = 0
            residuesSeq = []
            while i < (seq.length / 3)
              residuesSeq << rna_codons[seq[i..(i + 2)]]
              i += 3
            end
          end

          def mw(residuesSeq)
            weight = []
            residuesSeq.each do |i|
              weight << mw[i].to_f
            end
          end


          puts "The molecular weight of the protein is #{weight.inject(:+)}"

          # puts seq


          puts residuesSeq.join
