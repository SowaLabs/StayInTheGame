FROM microsoft/dotnet:2.2-sdk AS builder
WORKDIR /source

# RESTORE PACKAGES (with project files only)

COPY SowaLabs.FooService/SowaLabs.FooService.csproj \
     SowaLabs.FooService/

RUN dotnet restore SowaLabs.FooService/SowaLabs.FooService.csproj

# COPY ALL FILES
COPY SowaLabs.FooService/. SowaLabs.FooService

# COMPILE
RUN dotnet publish SowaLabs.FooService/SowaLabs.FooService.csproj -c Release -o /app

FROM microsoft/dotnet:2.2-aspnetcore-runtime AS runner
WORKDIR /app
COPY --from=builder /app .
RUN mkdir /cache
EXPOSE 80
ENTRYPOINT ["dotnet", "SowaLabs.FooService.dll"]