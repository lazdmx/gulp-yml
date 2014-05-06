File   = require "vinyl"
chai   = require "chai"
plugin = require "../"
expect = chai.expect


beforeEach ->
  @stream = do plugin
  @file   = new File path: "file.yaml"

it "should compile file", ( done ) ->
  @file.contents = new Buffer """
  person:
    age : 42
    name: 'Joe'
    cars:
    - uaz
    - gaz
  """

  @stream.on "data", ( file ) ->
    json   = null
    toJSON = -> JSON.parse file.contents.toString "utf-8"

    expect( file.path ).be.equal "file.json"
    expect( -> json = toJSON( ) ).to.not.throw( )
    expect( json.person.age ).to.be.equal 42
    expect( json.person.name ).to.be.equal "Joe"
    expect( json.person.cars ).to.be.eql [ "uaz", "gaz" ]
    do done

  @stream.write @file
  @stream.end( )

    
it "should throw error", ( done ) ->
  @file.contents = new Buffer "person: age: 42"

  @stream.on "error", ( e ) ->
    expect( e.name ).be.equal "YAMLException"
    do done

  @stream.write @file
  @stream.end( )
    
