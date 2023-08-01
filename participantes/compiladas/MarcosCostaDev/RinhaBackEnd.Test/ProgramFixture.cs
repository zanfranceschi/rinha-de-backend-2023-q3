using Microsoft.Extensions.DependencyInjection;
using RinhaBackEnd.Infra.Contexts;
using System.Diagnostics;
using System;

namespace RinhaBackEnd.Test;

public class ProgramFixture : WebApplicationFactory<Program>, IDisposable
{
    private HttpClient _httpClient;
    public HttpClient Client
    {
        get
        {
            if (_httpClient == null)
                _httpClient = base.Server.CreateClient();
            return _httpClient;
        }
        set
        {
            _httpClient = value;
        }
    }
    private IConfiguration Configuration;

    public ProgramFixture() : base()
    {
        var builder = new ConfigurationBuilder()
                          .SetBasePath(Directory.GetCurrentDirectory())
                          .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                          .AddJsonFile("appsettings.Testing.json", optional: false, reloadOnChange: true);

        Configuration = builder.Build();

        DropTestDatabases();
    }

    private void DropTestDatabases()
    {
        var appdb = new SqliteConnection(Configuration.GetConnectionString("PeopleDbConnection"));

        if (File.Exists(appdb.DataSource))
            File.Delete(appdb.DataSource);
    }


    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        builder.UseContentRoot(Environment.CurrentDirectory)
                        .UseEnvironment("Testing")
                        .UseConfiguration(Configuration);

        builder.ConfigureTestServices(services =>
        {
            var serviceProvider = services.BuildServiceProvider();

            services.Remove(ServiceDescriptor.Scoped(typeof(PeopleDbContext), typeof(PeopleDbContext)));

            services.AddDbContext<PeopleDbContext>(options =>
            {

                var sqliteConnectionString = Configuration.GetConnectionString("PeopleDbConnection");

                sqliteConnectionString = sqliteConnectionString.Replace("./", Environment.CurrentDirectory + "/", StringComparison.OrdinalIgnoreCase);

                options.UseSqlite(sqliteConnectionString);

            }, ServiceLifetime.Scoped);
        });


        base.ConfigureWebHost(builder);
    }
    protected override IHost CreateHost(IHostBuilder builder)
    {
        var appdb = new SqliteConnection(Configuration.GetConnectionString("PeopleDbConnection"));

        if (!File.Exists(appdb.DataSource))
        {
            var path = Path.Combine(Environment.CurrentDirectory, "App_Data");
            if (!Directory.Exists(path)) Directory.CreateDirectory(path);
        }
        return base.CreateHost(builder);
    }


    protected override void Dispose(bool disposing)
    {
        base.Dispose(disposing);
    }

    
    public void Dispose()
    {
        Dispose(true);
    }

    protected virtual void Dispose(bool disposing)
    {
        if (disposing)
        {
            Server.Dispose();
            Client.Dispose();
        }
    }

}

[CollectionDefinition("API", DisableParallelization = true)]
public class StartupFixtureCollection : ICollectionFixture<ProgramFixture>
{
}