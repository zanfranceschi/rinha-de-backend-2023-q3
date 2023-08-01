
using AutoMapper;
using AutoMapper.QueryableExtensions;
using RinhaBackEnd.CustomConfig;
using RinhaBackEnd.Domain;
using RinhaBackEnd.Dtos.Requests;
using RinhaBackEnd.Dtos.Response;
using RinhaBackEnd.Infra.Contexts;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

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

app.MapPost("/pessoas", async ([FromBody] PersonRequest request, PeopleDbContext dbContext, IMapper mapper) => {
    var person = new Person(request.Apelido, request.Nome, request.Nascimento);
    if (!person.IsValid) return Results.UnprocessableEntity(request);
    dbContext.People.Add(person);   
    dbContext.SaveChanges();
    return Results.Created(new Uri($"/pessoas/{person.Id}"), mapper.Map<PersonResponse>(person));
});

app.MapGet("/pessoas/{id:guid}", async ([FromRoute(Name = "id")] Guid id, PeopleDbContext dbContext, IMapper mapper) =>
{
   return Results.Ok(await dbContext.People.Where(p => p.Id == id).ProjectTo<PersonResponse>(mapper.ConfigurationProvider).FirstOrDefaultAsync());
});

app.MapGet("/pessoas", async ([FromQuery(Name = "t")] string t, PeopleDbContext dbContext, IMapper mapper) =>
{
    var query = PredicateBuilder.New<Person>();
    query = query.And(p => EF.Functions.Like(p.Nome, $"%{t}%"));
    query = query.Or(p => EF.Functions.Like(p.Apelido, $"%{t}%"));
    return Results.Ok(await dbContext.People.Where(query).ProjectTo<PersonResponse>(mapper.ConfigurationProvider).ToListAsync());
});

app.MapGet("/contagem-pessoas", async (PeopleDbContext dbContext) => {
    return Results.Ok(dbContext.People.Count());
});

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