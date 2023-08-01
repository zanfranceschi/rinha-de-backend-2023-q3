

namespace RinhaBackEnd.Test.Controllers;

[Collection("API")]
public class HealthControllerTest
{
    private ProgramFixture _fixture;
    private ITestOutputHelper _output;

    public HealthControllerTest(ProgramFixture fixture, ITestOutputHelper output)
    {
        _fixture = fixture;
        _output = output;
    }

    [Fact]
    public async Task HealthShouldBeSuccess()
    {
        var response = await _fixture.Client.GetAsync("/ping");

        response.EnsureSuccessStatusCode();

        var sut = await response.Content.ReadAsStringAsync();

        sut.Should().Be("pong");
    }
}
