# Use Red Hat Universal Base Image 8
FROM registry.access.redhat.com/ubi8/ubi

# Install necessary packages including Java and Git
RUN yum update -y && \
    yum install -y \
        net-tools \
        java-17-openjdk \
        wget \
        tar \
        git \
    && yum clean all

# Verify Java installation
RUN java -version

# Set JAVA_HOME explicitly to the correct path
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-17.0.12.0.7-2.el8.x86_64
ENV PATH=$JAVA_HOME/bin:$PATH

# Download and install Apache Maven
RUN wget -P /tmp https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz

# Extract Maven and clean up
RUN tar -xzf /tmp/apache-maven-3.9.9-bin.tar.gz -C /opt && \
    rm /tmp/apache-maven-3.9.9-bin.tar.gz

# Set Maven environment variables
ENV MAVEN_HOME=/opt/apache-maven-3.9.9
ENV PATH=$MAVEN_HOME/bin:$PATH

# Set working directory
WORKDIR /app

# Clone the Git repository
RUN git clone -b main https://github.com/Gaurav1517/spring-boot-java-demo-code.git .

# Run Maven build (mvn clean install)
RUN mvn clean install

# Default command (optional: can be replaced with the desired entry point)
CMD ["java", "-jar", "target/spring-boot-demo-0.0.1-SNAPSHOT.jar"]

