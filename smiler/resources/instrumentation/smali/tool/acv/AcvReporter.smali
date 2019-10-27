.class public final Ltool/acv/AcvReporter;
.super Ljava/lang/Object;
.source "AcvReporter.java"


# static fields
.field public static mCovered:[Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 14
    const/high16 v0, 0x200000

    new-array v0, v0, [Z

    sput-object v0, Ltool/acv/AcvReporter;->mCovered:[Z

    .line 15
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static saveExternalPublicFile(Ljava/io/File;)V
    .locals 3
    .param p0, "paramFile"    # Ljava/io/File;

    .line 21
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Ljava/io/File;->setReadable(ZZ)Z

    .line 24
    :try_start_0
    new-instance v0, Ljava/io/ObjectOutputStream;

    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v1}, Ljava/io/ObjectOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 25
    .local v0, "objectOutputStream":Ljava/io/ObjectOutputStream;
    sget-object v1, Ltool/acv/AcvReporter;->mCovered:[Z

    invoke-virtual {v0, v1}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    .line 26
    invoke-virtual {v0}, Ljava/io/ObjectOutputStream;->flush()V

    .line 27
    invoke-virtual {v0}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 31
    .end local v0    # "objectOutputStream":Ljava/io/ObjectOutputStream;
    goto :goto_0

    .line 28
    :catch_0
    move-exception v0

    .line 29
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 30
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ":reporter: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "AcvInstrumentation"

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 32
    .end local v0    # "e":Ljava/io/IOException;
    :goto_0
    return-void
.end method

.method public static setCovered(I)V
    .locals 2
    .param p0, "index"    # I

    .line 18
    sget-object v0, Ltool/acv/AcvReporter;->mCovered:[Z

    const/4 v1, 0x1

    aput-boolean v1, v0, p0

    .line 19
    return-void
.end method