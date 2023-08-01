using Xunit.Abstractions;

namespace RinhaBackEnd.Test.Controllers;

[Collection("API")]
public class PeopleControllerTest
{
    private ProgramFixture _fixture;
    private ITestOutputHelper _output;

    public PeopleControllerTest(ProgramFixture fixture, ITestOutputHelper output) 
    {
        _fixture = fixture;
        _output = output;
    }
    
}
