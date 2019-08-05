FROM microsoft/dotnet:2.2-sdk AS builder
WORKDIR /source

# RESTORE PACKAGES (with project files only)

COPY SowaLabs.BarService/SowaLabs.BarService.csproj \
     SowaLabs.BarService/

RUN dotnet restore SowaLabs.BarService/SowaLabs.BarService.csproj

# COPY ALL FILES
COPY SowaLabs.BarService/. SowaLabs.BarService

# COMPILE
RUN dotnet publish SowaLabs.BarService/SowaLabs.BarService.csproj -c Release -o /app

FROM microsoft/dotnet:2.2-aspnetcore-runtime AS runner
WORKDIR /app
COPY --from=builder /app .
RUN mkdir /cache
EXPOSE 80
ENTRYPOINT ["dotnet", "SowaLabs.BarService.dll"]