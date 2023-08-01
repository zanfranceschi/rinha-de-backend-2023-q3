
using RinhaBackEnd.CustomConfig;
using RinhaBackEnd.Infra.Contexts;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<PeopleDbContext>(options =>
{
    options.UseNpgsql(builder.Configuration.GetConnectionString("PeopleDbConnection"));
}, ServiceLifetime.Scoped);


builder.Services.AddCustomAutoMapper();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.MapGet("/ping", () => "pong");
app.MapPost("/pessoas", () => "Hello World!");
app.MapGet("/pessoas/{id:guid}", ([FromRoute(Name = "id")] Guid id) => "Hello World!");
app.MapGet("/pessoas", async ([FromQuery(Name = "t")] string t) => "Hello World!");
app.MapGet("/contagem-pessoas", () => "Hello World!");

if (app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseDeveloperExceptionPage();
    app.UseMigrationsEndPoint();
}
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "API v1");
});
app.Run();


public partial class Program { }