# Builds and runs the ASP.NET service. The published DLL is DotnetService.dll
# (from src/DotnetService/DotnetService.csproj); it listens on port 8096.
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish src/DotnetService/DotnetService.csproj -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENV ASPNETCORE_HTTP_PORTS=8096
EXPOSE 8096
ENTRYPOINT ["dotnet", "DotnetService.dll"]
