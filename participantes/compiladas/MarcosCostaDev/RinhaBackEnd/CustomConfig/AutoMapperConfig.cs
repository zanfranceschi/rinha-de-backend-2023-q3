using RinhaBackEnd.Mapping;

namespace RinhaBackEnd.CustomConfig;

public static class AutoMapperConfig
{
    public static IServiceCollection AddCustomAutoMapper(this IServiceCollection services)
    {
        var mapperConfig = new MapperConfiguration(cfg =>
        {
            cfg.ShouldMapProperty = pi => pi.GetMethod != null && (pi.GetMethod.IsPublic || pi.GetMethod.IsPrivate);

            cfg.AddProfile(new MapProfile());
        });

        IMapper mapper = mapperConfig.CreateMapper();
        services.AddSingleton(mapper);
        return services;
    }
}
